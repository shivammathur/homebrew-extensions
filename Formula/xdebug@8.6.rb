# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/5d24b43b7401bd35e68f168eb68293b363cb5b24.tar.gz"
  sha256 "28f2645e4465559d1d1e837829af200ec1ecc4ba17dadeb2c4c763960fc453ea"
  version "3.5.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 3
    sha256                               arm64_tahoe:   "937ba060eef1639ee82ec6a6a65671df98f3c1df391713ca4d92e1e77f881b07"
    sha256                               arm64_sequoia: "f762a7712f0413a89f8ed28051e061888add9d5bca4e36208be27b158441d243"
    sha256                               arm64_sonoma:  "e6fea53250bfcbe2e9ad894f97d17ea1840f50870dbf7d0293d72a932b609ebc"
    sha256 cellar: :any_skip_relocation, sonoma:        "9231fcd6eeb3bb575c87d3da2d09c009d178690af5203261d2fb48e5e362acf3"
    sha256                               arm64_linux:   "f700c6c450aa698ad018808f5873f77ea7f244f2c8ff00587f6f4eeffbe09032"
    sha256                               x86_64_linux:  "d847e17dedd882ce7f638b1c4338c0a4e021bcdd8dabf9e61c12c0047e7d3253"
  end

  uses_from_macos "zlib"

  patch do
    url "https://github.com/shivammathur/xdebug/commit/13264e7ca3608026f710fb83c5f2314bdcc610e6.patch?full_index=1"
    sha256 "2c0ed06d8adcbdd534132bf4a30a8497a236b576d3dff4c92f1375ec0436f98b"
  end

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
