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
    rebuild 1
    sha256 cellar: :any,                 arm64_tahoe:   "bf3b0cd6a2888be153095b03709e0d0747c446416ae03b5707a07d8d587d2790"
    sha256 cellar: :any,                 arm64_sequoia: "1cd5b503441142d5959e428d2af119d9287affe6fec6f00fa95d6c7a2a8eb3e6"
    sha256 cellar: :any,                 arm64_sonoma:  "30a2e4de668b08b10ba7d95aff2a897ca73d538c0ce0e634f6563eb7ba0a1501"
    sha256 cellar: :any,                 sonoma:        "21061f1d7c6da18eb28ec874369d9c95eb8c009bc2f2548c975cdd43322d7e2b"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "a35c6b671801e9eeef81920a696b4b7221b00478ee0b0155fe342cd48809b679"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "5d63cdd84cb396cd5a65e3eb5afaa865e359a6f05c6b56174389ae2d3bffa227"
  end

  depends_on "rabbitmq-c"

  patch do
    url "https://patch-diff.githubusercontent.com/raw/php-amqp/php-amqp/pull/595.patch?full_index=1"
    sha256 "8bc0eccc30770211ccb9b6413afbdebe2f93c43550d6e02c105143416736f6d1"
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
