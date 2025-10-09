# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Amqp Extension
class AmqpAT86 < AbstractPhpExtension
  init
  desc "Amqp PHP extension"
  homepage "https://github.com/php-amqp/php-amqp"
  url "https://pecl.php.net/get/amqp-2.1.2.tgz"
  sha256 "0cb16d63752a0055de55a22062a6c1744908696d92268d76181284669025d993"
  head "https://github.com/php-amqp/php-amqp.git", branch: "latest"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/amqp/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "4c2f43e1480176a457690b2572414127d4b15a4c03b3f64afa988598bdd0b8d5"
    sha256 cellar: :any,                 arm64_sequoia: "c66bec7fe6e96d2cba35e42ac6dc85b2c450d28ae877ee157878e3cc6c4b33c2"
    sha256 cellar: :any,                 arm64_sonoma:  "7a4753749b41e6288005856e188e3f3a3a3f79741887388e2d6f9b98a0240d99"
    sha256 cellar: :any,                 sonoma:        "ddc26bddb7f33372529029dbf2ef503436a8a2c8b9e98596164c7686f062b5d2"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d0367e87b304c2a6e4c27d1cc1adeb93823f214238b3043295168fd57f032552"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c0d3127956f7819ed5800a8f251e306418241c353cd7724df1ebb075a5eeccf4"
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
