# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT80 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.1.1.tgz"
  sha256 "4e5946397cc5dca06122d980658d8cc5b261b985bf2b8f90cd5d873e0d9d36c0"
  head "https://github.com/phalcon/cphalcon.git"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "62052df648baa3c34b80f7a8908d41984ef6997fdf69b2c1e552a4e5aabe9a17"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "bdeda8bcc295a4a6135cff482fce4d8985e3adcfe12358bac662f002b1d65092"
    sha256 cellar: :any_skip_relocation, monterey:       "6a20220bc7c42341cc402fcd118b08c88d7a0678f2dd88bf8ba7e5518ef70706"
    sha256 cellar: :any_skip_relocation, big_sur:        "743f1f3634860e7971cd3eef0cc566f908e43213288e61e51ec4b551cbf8b6c5"
    sha256 cellar: :any_skip_relocation, catalina:       "ef963c5a45367eb80a5f7fd2c2e2b3784a2a1497fd0fcc4ffbbfe0ba996a6c8b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "82655197e942796649447b79efdd1afd8cbc06a73d48cc7674200a68e8e39a2b"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
