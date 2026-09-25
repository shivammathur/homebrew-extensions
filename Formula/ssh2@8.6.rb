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
  revision 2
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "8896c802baf5dd0bee868a21b1d88e0d4168ff8e4ec6bfbe0cc30ec93c67d308"
    sha256 cellar: :any, arm64_tahoe:       "b11b6b29b176e443b720302f92a6909568cbbb429ce4f820b536f1fb0ecb37c1"
    sha256 cellar: :any, arm64_sequoia:     "4f7dea23bf11bf170e799760af82c18728aa351e873481da7382453e3cbb6c41"
    sha256 cellar: :any, arm64_linux:       "77e6923412e6c922799a3d4877356da980b84ac7de4ebdf8f52fe27f18961b88"
    sha256 cellar: :any, x86_64_linux:      "bdd8cd3bb2998f8c32e851ae3bf1fb4e8be62dcbafdfaf04ad58daa11040612c"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
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
