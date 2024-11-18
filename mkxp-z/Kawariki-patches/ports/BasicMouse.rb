module Input
    class BasicMouse
        include IBasicMouse

        # コンストラクタ
        def initialize()
            # 関連付けられたウィンドウのハンドル
            @hWnd = 0

            # 前回のマウスの状態
            @prev = nil

            # 現在のマウスの状態
            @curr = nil

            # ボタンの配列
            @buttons = Array.new(self.NumButtons()){ |i| i = ButtonInfo.new() }

            # 何かボタンが押されているか
            @isPressedAnyButton = false

            # ステータス情報文字列を更新すべきか
            @needToUpdate = true
        end

        # 初期化処理
        def Initialize(hWnd)
            @hWnd = hWnd
            @curr = DIMOUSESTATE2.new(hWnd)
        end

        # 更新処理
        def Update
            # マウスの更新処理
            @prev = @curr
            @curr.Update()

            @isPressedAnyButton = false
            for i in 0..NumButtons() - 1
                @buttons[i].Update((@curr.rgbButtons[i] & 0x80) == 128 ? ButtonStatus::Pressed : ButtonStatus::Released)

                if @buttons[i].Pressed()
                    @isPressedAnyButton = true;
                end
            end

            @needToUpdate = true
        end

        # IBasicMouse::GetStatusString() オーバーライド
        def GetStatusString
            if @needToUpdate
                def Static
                    leftButton   = Keys::Key.new(0, "LeftButton",   "左ボタン")
                    rightButton  = Keys::Key.new(1, "RightButton",  "右ボタン")
                    middleButton = Keys::Key.new(2, "MiddleButton", "中央ボタン")
                    xButton1 = Keys::Key.new(3, "XButton1", "Xボタン1")
                    xButton2 = Keys::Key.new(4, "XButton2", "Xボタン2")
                    xButton3 = Keys::Key.new(5, "XButton3", "Xボタン3")
                    xButton4 = Keys::Key.new(6, "XButton4", "Xボタン4")
                    xButton5 = Keys::Key.new(7, "XButton5", "Xボタン5")
                    @keyTable =
                            [
                                leftButton,
                                rightButton,
                                middleButton,
                                xButton1,
                                xButton2,
                                xButton3,
                                xButton4,
                                xButton5
                            ]
                end
                self.Static()

                puts sprintf("Position         : (%5d,%5d)", self.X(), self.Y())
                puts sprintf("Velocity         : (%5d,%5d,%5d)", self.VX(), self.VY(), self.VZ())
                puts "[ButtonName]                 [Pressed]        [Released]     [Repeated]"

                for i in 0..(NumButtons() - 1)
                    puts sprintf(
                        "%-20s        %4s%4s%6d     %4s%4s        %4s%6d",
                        @keyTable[i].GetName(),
                        @buttons[i].Pressed() ? "ON" : "OFF",
                        @buttons[i].JustPressed() ? "ON" : "OFF",
                        @buttons[i].GetContinuousCount(),
                        @buttons[i].Released() ? "ON" : "OFF",
                        @buttons[i].JustReleased() ? "ON" : "OFF",
                        @buttons[i].Repeated() ? "ON" : "OFF",
                        @buttons[i].GetRepeatCount()
                    )
                end
                print("\n")
            end
        end

        # マウスの最大ボタン数
        def NumButtons; return 8; end

            # IBasicMouse::GetPosition() オーバーライド
            def GetPosition
                pos = System::Math::Vector2.Zero()
                pos.x = @curr.lX; pos.y = @curr.lY;
                return pos;
            end

            # IBasicMouse::SetPosition() オーバーライド
            def SetPosition(x, y); Win32RGSS::Cursor::SetCursorPos(x, y); end

                # IBasicMouse::GetVelocity() オーバーライド
                def GetVelocity
                    pos = System::Math::Vector2.Zero()
                    pos.x = @curr.lX; pos.y = @curr.lY;
                    return pos
                end

                # IBasicMouse::X() オーバーライド
                def X; return @curr.lX; end

                    # IBasicMouse::Y() オーバーライド
                    def Y; return @curr.lY; end

                        # IBasicMouse::VX() オーバーライド
                        def VX; return @curr.lX - @prev.lX; end

                            # IBasicMouse::VY() オーバーライド
                            def VY; return @curr.lY - @prev.lY; end

                                # IBasicMouse::VZ() オーバーライド
                                # def VZ; return @curr.lZ / 120; end
                                    def VZ
                                        # Check if @curr and @curr.lZ are valid (not nil)
                                        return 0 if @curr.nil? || @curr.lZ.nil?
                                        return @curr.lZ / 120.0 # Ensure division results in a float
                                    end

                                    # IBasicMouse::LeftButton() オーバーライド
                                    def LeftButton; return @buttons[0]; end

                                        # IBasicMouse::RightButton() オーバーライド
                                        def RightButton; return @buttons[1]; end

                                            # IBasicMouse::MiddleButton() オーバーライド
                                            def MiddleButton; return @buttons[2]; end

                                                # IBasicMouse::XButton1() オーバーライド
                                                def XButton1; return @buttons[3]; end

                                                    # IBasicMouse::XButton2() オーバーライド
                                                    def XButton2; return @buttons[4]; end

                                                        # IBasicMouse::GetButtonState() オーバーライド
                                                        def GetButtonState(index); return @buttons[index]; end

                                                            # 1つ以上のボタンが押し下げられている時にはtrueを返します。
                                                            def IsPressedAnyButton; return @isPressedAnyButton; end
                                                            end
                                                        end
