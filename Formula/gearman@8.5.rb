# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Gearman Extension
class GearmanAT85 < AbstractPhpExtension
  init
  desc "Gearman PHP extension"
  homepage "https://github.com/php/pecl-networking-gearman"
  url "https://pecl.php.net/get/gearman-2.1.2.tgz"
  sha256 "46ac184d0f67913ef5fbbd65596bd193a2ef11a7af896a7efd81d671a5230277"
  head "https://github.com/php/pecl-networking-gearman.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "06119717494d2b5b442d4b38a50559deb506ea01ffa6fcf2d52c95c37568d484"
    sha256 cellar: :any,                 arm64_sonoma:  "d53a3c2e13f2cdc2da27fe1158f3517a1fdabbb9fc97c9073e76d95face767d4"
    sha256 cellar: :any,                 arm64_ventura: "db17a9c8630b1ed9bf340a22054c3411fe1a5ebded141d39e534c9ab968facd7"
    sha256 cellar: :any,                 ventura:       "ce08101678698ae072e7f03d8a498be1c9ec4098f54447dd3a9510188ad3ffbb"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0a3caacd75cd1bba002e05a6065148e0eb32901fb2017aeb9f7505dc8f7d62b5"
  end

  depends_on "gearman"

  def install
    args = %W[
      --with-gearman=#{Formula["gearman"].opt_prefix}
    ]
    Dir.chdir "gearman-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
