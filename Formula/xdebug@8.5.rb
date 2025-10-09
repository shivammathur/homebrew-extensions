# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/eeb4338afe11269635e272596841485474d7374f.tar.gz"
  sha256 "8499114ec7e270c108d9bc284ddd877e57d44ce3b465ecfde6a46c4381c97be2"
  version "3.4.5"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256                               arm64_tahoe:   "af9e2ea8e5124aafba6514587ab43d00c4768d4b4bda6bc50a8a94c3915b799f"
    sha256                               arm64_sequoia: "520da03644b281ce45ec743eac0b0e50399814e5a29c1e8f2bfac26bd1c0d236"
    sha256                               arm64_sonoma:  "8b35f73dfa2dc4d132cf4873d06de7868274f2f623dbc6187ac7f9b8c3039ba0"
    sha256 cellar: :any_skip_relocation, sonoma:        "56c7018229a5641a6d57ec9f58153150f4fa281180cb39b493b7e1a8e45bc37c"
    sha256                               arm64_linux:   "83af220452540876ad721c9e0a396554a9e680fd1a4949188d712c32c330fc31"
    sha256                               x86_64_linux:  "01402b700a508bbf0719f96fcffd16602b2e1b97c4ea9647fbcc0c8f61e5dd4f"
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
