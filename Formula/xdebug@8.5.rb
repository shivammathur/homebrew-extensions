# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/65e43ec5e11adc05f306663b5dc511ccf9001121.tar.gz"
  sha256 "fc14a0307989695f787796073954b87d0bc4aff89c6f0e89e2195d84ea4957da"
  version "3.4.5"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256                               arm64_tahoe:   "a81b36fbbae550e3288a4bd6365a83b7300de15cb9bc81ad13170734a6356522"
    sha256                               arm64_sequoia: "e31557ffc7510fe97df9ce4484bdeb141d11c93c08c5221ca98dde8437955d18"
    sha256                               arm64_sonoma:  "bff508ac84afebfec7ec83345da65e4434ce477c8aea63b09c1754611c4d222a"
    sha256 cellar: :any_skip_relocation, sonoma:        "3e828cc58c454b85a44e9aec04baf027bddb169486d055190595472c697a2c36"
    sha256                               arm64_linux:   "a82b657a18e3903d4084d92ac0529ed6a2dce5e01a8b946c25cee17c006f4a7b"
    sha256                               x86_64_linux:  "d8f8479a8bad6f26bf55eb184b4819fe3d2dce4565ddce50b5d51a79bcbd11c4"
  end

  uses_from_macos "zlib"

  def install
    inreplace "src/lib/maps/maps_private.c", "xdebug_str *result_path", ";xdebug_str *result_path"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
