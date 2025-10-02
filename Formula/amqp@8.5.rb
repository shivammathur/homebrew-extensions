# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT85 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://github.com/php-amqp/php-amqp/archive/refs/tags/v2.1.2.tar.gz"
  sha256 "5eebe1d0414af8e4c1e1b5040be68168a533704f09f6f66e4d48ab78edd1d8d2"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_tahoe:   "6c3b37c8c288a119b13e886da4a09b156aea21edd758f5ed66f590b57cc3c37a"
    sha256 cellar: :any,                 arm64_sequoia: "6c5c95a9633e8945738cab1e33da283eb103014af3d79efb42104ef6065d5359"
    sha256 cellar: :any,                 arm64_sonoma:  "7ea12e8af79d1cf23fc6c734a26fcf0abde8f765609ec176d76131e9c6e390df"
    sha256 cellar: :any,                 sonoma:        "36d0f2cee25543564db4a0cdfd2a70ff29412715136f7c06d59311c753e141cc"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7fbcb0eaa6279d402f508ed04b0ceaa5dfb5cefe21861dc12b10738cea32ab1c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "326707cdd2e0fd4e226ad5801b569df8b511f210e16c685a8fb8a1db2818f052"
  end

  depends_on "rabbitmq-c"

  patch do
    url "https://patch-diff.githubusercontent.com/raw/php-amqp/php-amqp/pull/595.patch?full_index=1"
    sha256 "0e7876fb89ddbcaf470836df38cf010d38555ba0d50050f912c7d0f226602938"
  end

  def install
    args = %W[
      --with-amqp=shared
      --with-librabbitmq-dir=#{Formula["rabbitmq-c"].opt_prefix}
    ]
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
  end
end
