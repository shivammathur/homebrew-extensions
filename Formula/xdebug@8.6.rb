# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xdebug Extension
class XdebugAT86 < AbstractPhpExtension
  init
  desc "Xdebug PHP extension"
  homepage "https://github.com/xdebug/xdebug"
  url "https://github.com/xdebug/xdebug/archive/57486fa8dad31de41c2d9c35d711c7f2e8970abd.tar.gz"
  sha256 "2b2160df79f7abe002730150fefb224c9d6a55471a34c080fa83c5e8dd530620"
  version "3.4.5"
  head "https://github.com/xdebug/xdebug.git", branch: "master"
  license "PHP-3.0"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256                               arm64_tahoe:   "540fde1ede8c40a322b381b89eec2b23e1feaec2efb07fe63e783766a4d908cf"
    sha256                               arm64_sequoia: "78fab675bf3fcfa62a05b91fc880c355aa95dc2006e763215d8075d754c567f8"
    sha256                               arm64_sonoma:  "1a781319285cabb86e1c83ce383caa876d056d5d41ecba1dd034676e9c5d47e9"
    sha256 cellar: :any_skip_relocation, sonoma:        "b8aefed3ba72e73c14beee4a9da2102be1dfac0062395ab860b500da1b4062a1"
    sha256                               arm64_linux:   "6a351bad06f50bdebd30f07095ae3387ad13e2e1725e235212deed14b1a03e6e"
    sha256                               x86_64_linux:  "b68be393247528502d51b93661f3dfc17d0635b54d4019a05db4c5d13307453e"
  end

  uses_from_macos "zlib"

  def install
    inreplace "config.m4", "80600", "80700"
    inreplace "src/profiler/profiler.c", \
              "ZSTR_INIT_LITERAL(tmp_name, false)", \
              "zend_string_init(tmp_name, strlen(tmp_name), false)"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-xdebug"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
