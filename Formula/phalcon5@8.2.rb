# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.2.3.tgz"
  sha256 "f624b4557920aae70f2146eec520b441cf28497269ec81e512712fb3ef05364e"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "7fdd64c64cd036a92ad38243d742ca7893233f69b9abc6bfff235ece343a0e12"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "2347dff94894c1e01e0d3a857971a8348916b0efae75ca10255387e7d63ca8b1"
    sha256 cellar: :any_skip_relocation, ventura:        "e7cc6febc78b47ec8189d08381b493b5363d1227de2163df0f54b1269d63927d"
    sha256 cellar: :any_skip_relocation, monterey:       "299fe979e12e90efdae2387917bc1267cd69264a02c48b47d955f3bf92093f42"
    sha256 cellar: :any_skip_relocation, big_sur:        "a5c561836ef25a9b6c9d7b98cedd926f9f125eee4717e99172124268aa16e21a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b12dabfdf6334f517ee5488c8d0718bba1afd6a8aac041e97bbdce2f8b1ceb20"
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
