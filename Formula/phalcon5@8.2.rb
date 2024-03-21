# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.6.2.tgz"
  sha256 "1b07edf639177ae3491d0fd8f223193c65f38870b621572f7d5465ca81ae2ac7"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "1ef538ef8d7529eb099de2d4d46fdbb594271932d1cd70c4656634d8838fad06"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "9a39b7a5392a4ab7163c9edac8cf263070cf57c6d2bff1928d722648e9ad5420"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "25bffb30424f32d53a61b5d5644c284d744821f8f657c66f217d32bcb416829a"
    sha256 cellar: :any_skip_relocation, ventura:        "cfa2ecb84acca33d6ccf8eda3b577cb92cadf7480db94b676d18675063e66860"
    sha256 cellar: :any_skip_relocation, monterey:       "892c1045e1879b3137e88c6665ab866bd78e3248bddf4966edd1200d92ea6907"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2906dbecfefc33e285feb654613d1c18ba64c890557914d369ffbe270740e09d"
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
