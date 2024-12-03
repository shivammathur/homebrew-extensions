# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT85 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/8793825438dc539bbc15f39369cab4f01318431b.tar.gz"
  sha256 "6cef4d23af57c595f642e7e00eef87a8f805845c108e0ea851c4bcb1ea698ec2"
  version "3.4.0"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 arm64_sequoia: "b1467f8943049fe80656e6af0ff8c0d7809a5afb475da6651045abbe88c3418a"
    sha256 arm64_sonoma:  "caaf42298f73c39c37cf9c85a63a0312a86c4669d6e01aa3e01961f599e071b1"
    sha256 arm64_ventura: "19fdbfdd1903ee7e5d6bbce5cf87a15fb900d5c9b37f4c29c28195a16cf3d48d"
    sha256 ventura:       "ea66b4ab33118c7501182798924b827388382317947c0063335e8629c77622e2"
    sha256 x86_64_linux:  "76b5a6869b9bf6f231e1fdfd528cd7c9575d5421864fe84a5d29feddfe74cee2"
  end

  uses_from_macos "zlib"

  def install
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
