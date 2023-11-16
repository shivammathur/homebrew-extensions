# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "4bd29f3e1a2f7c7c62148cd695f83dba95e4eda1989bd442722c94c2cc727da2"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "2854236d52456dbbab3b0fbbc0cf57ab8eec783663d5580677931e61868cf5ea"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "cf994ab58d2587987558884f7efd2aa5ae5d4fe9837e8d6941f0e7e74b7bc5da"
    sha256 cellar: :any_skip_relocation, ventura:        "2ae1d1457992d4f514a51ce8ff1c835df97c554a235fdc718115f21fff4ff88f"
    sha256 cellar: :any_skip_relocation, monterey:       "0c449b11e11ff4aa3c7b4f6ad1858ae1f61aac0bfcc8a861fec3c9204c5f7d4a"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "ede5ad3d4242cd32a8a4e5ce2617e5bdd22b2fc832d6f8e625b7a23e69b69937"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
