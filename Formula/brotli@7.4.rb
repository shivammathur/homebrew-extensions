# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT74 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.19.0.tgz"
  sha256 "27d406ba894015352e305c8b557812ffd70b3899b6a519ab874c99e42675cd3a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any, arm64_tahoe:   "a9a30b5a552a1829156505fc55503fd97bfa9a9ab2a20dbcbe1a12bd97909d0b"
    sha256 cellar: :any, arm64_sequoia: "1b731f11babaf162072dea593e493ca6802bdc6c8afd9e48a65a745e745dcd16"
    sha256 cellar: :any, arm64_sonoma:  "ae5ddb8c44ff7c2b9fb1cd6eedb44380b92af3465c46a33bae10682a59018c5c"
    sha256 cellar: :any, sonoma:        "635be51a6655c4a2b6e7b480e5eea5e01556efb12606a1e30269bab372260390"
    sha256 cellar: :any, arm64_linux:   "4daa144e9b57bb0c014d5e40833b027bee8d1be54e0b30b66940083a1a4fad9a"
    sha256 cellar: :any, x86_64_linux:  "fbbb0d0da568be466c9abebde09746219e202402d862b0faff13dff25981c15e"
  end

  depends_on "brotli"

  def install
    args = %W[
      --enable-brotli
      --with-libbrotli=#{Formula["brotli"].opt_prefix}
    ]
    Dir.chdir "brotli-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
