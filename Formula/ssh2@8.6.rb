# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT86 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.5.0.tgz"
  sha256 "a943427fae39a5503c813179018ae6c500323c8c9fb434e1a9a665fb32a4d7b4"
  revision 1
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "f85ea4b0c75b467059c95b6ede9fa39cc168c3123adf4193834afdc0a608720e"
    sha256 cellar: :any,                 arm64_sequoia: "a5ee99ba9efa39608fcd5a812e680b91f8503a40028b35a133c5e070369d2101"
    sha256 cellar: :any,                 arm64_sonoma:  "08b15b070e1cf38d666a507aea94cd3e9d5f299a7855b08977bc8c9cb5493010"
    sha256 cellar: :any,                 sonoma:        "02219562e505037a1fc143016702a0d1a2d571654c54cf93e48d5d15e19da259"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "867b32388d44873c941e3f7c738522e04810f864f83ef186e6b5ed37bc2895b6"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "139be996a0794794b7dd5b7f31da42645f2a5ce6846e65551ce3bc9bee7784c7"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Formula["libssh2"].opt_prefix}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "zval_is_true(&zretval)", "zend_is_true(&zretval)"
    inreplace "ssh2_fopen_wrappers.c", "zval_dtor(&copyval);", "zval_ptr_dtor(&copyval);"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
