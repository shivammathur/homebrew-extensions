# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Brotli Extension
class BrotliAT84 < AbstractPhpExtension
  init
  desc "Brotli PHP extension"
  homepage "https://github.com/kjdev/php-ext-brotli"
  url "https://pecl.php.net/get/brotli-0.18.3.tgz"
  sha256 "ed3879ec9858dd42edb34db864af5fb07139b256714eb86f8cf12b9a6221841a"
  head "https://github.com/kjdev/php-ext-brotli.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/brotli/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "66d225995c6f388ad378cb8aa945fbc184f936fa46be0d0b1e8a18bc72bcf7ff"
    sha256 cellar: :any,                 arm64_sequoia: "a8095858a2956c885db4dd48d5c079bfc995c7718cce72067388d6b2b394a88c"
    sha256 cellar: :any,                 arm64_sonoma:  "82b99ac4bbd0b81d4238f100a25267af430dd26c199b9dc63884eb6ea3e0da43"
    sha256 cellar: :any,                 sonoma:        "3cf54427a81b78b6cd9f922a154c9e8150f49c391c92e5f5f48c30e45f51c006"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "179be0dde84d84f041be545327fef42caa8999cfe05ad7d0061be724d175fbf1"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b97ed444e97dcb684c28ca2b3028057ec94d50851688729815ed5ffc4b9c03b4"
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
