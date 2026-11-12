# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ssh2 Extension
class Ssh2AT74 < AbstractPhpExtension
  init
  desc "Ssh2 PHP extension"
  homepage "https://github.com/php/pecl-networking-ssh2"
  url "https://pecl.php.net/get/ssh2-1.6.0.tgz"
  sha256 "2342df367fb01a789a1b9f6c9c780f5221c51e9c00bf1cd1dd8a5c38b98d4cc5"
  head "https://github.com/php/pecl-networking-ssh2.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/ssh2/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_golden_gate: "0ef72ec29a6751af9445d86540c90fbddb53f7272f64461472737f9b9530e361"
    sha256 cellar: :any, arm64_tahoe:       "a7f40d677cb78eb1c44d625375b5680c73e1a76cb74ad36985bc0bf7ad6e6ef9"
    sha256 cellar: :any, arm64_sequoia:     "6d17b255257b80df696e27820445cb1268bc8d59fbb2dbbd6eb6eb3591310ac3"
    sha256 cellar: :any, arm64_linux:       "0f20afcd58fc69e4037443e707f5c3deb83a8077ea5f00bb95cfb7a14a0472ce"
    sha256 cellar: :any, x86_64_linux:      "ded4a372cc14c8f9dd4a4a6377f00bc967e40d04e03299910ec87161bcc3ff2a"
  end

  depends_on "libssh2"

  def install
    args = %W[
      --with-ssh2=shared,#{Utils::Path.formula_opt_prefix("libssh2")}
    ]
    Dir.chdir "ssh2-#{version}"
    inreplace "ssh2.c", "#include \"Zend/zend_attributes.h\"\n", ""
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
