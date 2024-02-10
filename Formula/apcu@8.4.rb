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
    rebuild 1
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "00d5e1ddbf429f10c3cafe2956ccafc306a87f7b899c64b82f875b1f116d40f9"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "164e199f928d7c9d28e913e23dee3669341ce55d9d8bafed7128eeb8ec541921"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c237279ea18b205fc0acb3cd60864b81ab21dae52eda2aea7efae9f535b7b3d8"
    sha256 cellar: :any_skip_relocation, ventura:        "43286ac422a0da3103c2af667b2296b1d2cb004414ff6ce91ef1aab801fecc9b"
    sha256 cellar: :any_skip_relocation, monterey:       "91bd880c4538f2d1ee43beddef2a34cf0e9f1205e0d6ae3ecbf96da48677438e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "a9558b2fd8046cc134c81f4a4b40db7a34fa3d2a7491ee65aea2431eddff6e53"
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
