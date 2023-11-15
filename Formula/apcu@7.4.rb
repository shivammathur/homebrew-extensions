# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT74 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.23.tgz"
  sha256 "67ee7464ccad2335c3fa4aeb0b8edbcf6d8344feea7922620c6a13015d604482"
  head "https://github.com/krakjoe/apcu.git"
  license "PHP-3.01"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "1f7aebd70de32ab1ede54613c934bbbb9b205e4aaf22eaea6276f1c013417564"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "c0b77dbc84b3396596ca51310eb49bd614f462e9fb773e9893b423082ad629e1"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "00c38ea60a39f9e80fc45b57bccd734b7fad59a8fcca38ae9b97eb8130f40520"
    sha256 cellar: :any_skip_relocation, ventura:        "97245242dd0303328a05866688f3ac8a994d8d7ad9ef62fc1a8ef1d437cbe1dc"
    sha256 cellar: :any_skip_relocation, monterey:       "e746b73d27988136c9a68cfdfd150b8363d3fbd2943434c4ed332f464794ae45"
    sha256 cellar: :any_skip_relocation, big_sur:        "bb4ebe2ebe53852f859030350aa9f80362f8b0c4c338e781f44b52d12c314ecb"
    sha256 cellar: :any_skip_relocation, catalina:       "dff6bf3da82365947f7cfa508af107c6d30a054ad46519ac20c2d3c0d8d916c5"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "15cb597314c56abe6ee62fcd78a39854a7e8abd6f12dd50b16c8a09c2a91907a"
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
