# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/eb6378f2feb65e6f26ab172cb42d478aa4b5e7f1.tar.gz"
  sha256 "26d379b9da7a4bb1e120ad304364d8f3611183474015df4bf1669aa63521bdc9"
  version "3.4.5"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 5
    sha256                               arm64_tahoe:   "f0aa47e16616acc92b28a82ad5791b7e15ddd4357a6bec008114baf07ce60f59"
    sha256                               arm64_sequoia: "edeccd9cd3788c87065c779cc3329e34f8bdf671b84c3d3ba513e50e538061f9"
    sha256                               arm64_sonoma:  "0402dc5aafc3ba3dc711fac5ba786e49a430333a14e72aac5ee66040146a685a"
    sha256 cellar: :any_skip_relocation, sonoma:        "35661145445624ec81a753e3cca91fbba6fbeaa7f8364802ad28a9e83a50ce0a"
    sha256                               arm64_linux:   "d99f7aa86aec630dd0860b45b81324cf11a306795340f24735803c7cd3d55a31"
    sha256                               x86_64_linux:  "e938d06adc01baba7e40e7c38da8c898340bfef11bdc409926c28a7148c93080"
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
