# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/6e86e8602ddacf3f7473c3bd14c0c8b57d64c10c.tar.gz"
  sha256 "c9fc5d2f423bc32f6651f4ad3155d3ccb2c396af07cec333a5c7dd00d897d52d"
  version "3.5.0"
  revision 1
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 6
    sha256                               arm64_tahoe:   "f4befc076e90ae8c5808a1547730a8ec43efa216066a322cfe9f5ac8255ca1f9"
    sha256                               arm64_sequoia: "6172763487771ed93acc19dae55d8f8ac6749ff1f9167abded1cf24445894797"
    sha256                               arm64_sonoma:  "0d2108d308e92dd05a11352a91b754cb4b24bf90a7125f63e03b197356418304"
    sha256 cellar: :any_skip_relocation, sonoma:        "c422ab9540a638648936cf4f4513db1ffcd67f135235852e25102d63100c1431"
    sha256                               arm64_linux:   "3baff9632bc7c1e0d964cc9555554ddef60b12c4489f39886a6e2ef228777812"
    sha256                               x86_64_linux:  "aef78b59f1ac91bdf999e238a0c7216265c7d8b7fd9f214f6f2b05facb5818f7"
  end

  on_linux do
    depends_on "zlib-ng-compat"
  end

  def install
    inreplace "src/develop/stack.c" do |s|
      s.gsub! "INI_STR((char*) ", "zend_ini_string_literal("
    end
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
