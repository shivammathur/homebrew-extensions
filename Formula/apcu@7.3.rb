# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT73 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "d9ea8da9ab91400efb8b66a52467c8011a3e43b09a36ceee835cf7cf4fae0ab7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "1af9df4b2a8ab9668b2988caa3c25c2078b80803f6b682e6be936756fda1449e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "d6f09de7f9c807a507c5db9675be3a799c9b78ec980a0f53656300f5c0c796ff"
    sha256 cellar: :any_skip_relocation, ventura:        "48a8dd9ebb42abf95bcda79ac1892a6616348032e9baf2f3e484cbb7e68186aa"
    sha256 cellar: :any_skip_relocation, monterey:       "bb17411ff19a219a80a47ca2c8762ba4beb09abb4f6e896c9d587428b5c65122"
    sha256 cellar: :any_skip_relocation, big_sur:        "057abd92994d8ce0268ee29af0036f8149ba88d6510e6fbd552eb3da262259f0"
    sha256 cellar: :any_skip_relocation, catalina:       "e76c167bbe0e46d606f382d48b8200040a261c792a6c2beeb8653eec7b800481"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4310959f3e622da4d0673a1c730f9af247a84b7d5df06ff55f4ebfb71bd444bc"
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
