# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT70 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sequoia:  "022c17529e175320a24f73be18bb253e1fe786b689c6834bd4a8f58c0dbee9d5"
    sha256 cellar: :any,                 arm64_ventura:  "d971e9d1d9acfdb7e105cb04d201e92951661523fd4596c9096eb1977c7c6a62"
    sha256 cellar: :any,                 arm64_monterey: "07bea378c6173b40a07bb03558c5661cb4363f2dae4db1aca7a06e7237cc0f3b"
    sha256 cellar: :any,                 arm64_big_sur:  "8d08157ec2639866df4ed44c2ab9e944b2cc177cc2b9e1be1b0544a1747a4acd"
    sha256 cellar: :any,                 ventura:        "88b9b50155de6b9522ec56f80c64a7561cf33d401dffe95af2a38f7f3b965622"
    sha256 cellar: :any,                 monterey:       "d5406ddfc783c14c720dc737cfc87bcbb301aebc02b8ddbe896faea483e110ef"
    sha256 cellar: :any,                 big_sur:        "18cb01af3629452c2063d0bbd0d40500079c9afae8cec8b5d102113957b246ca"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "b7ffdeba4bff9f17cdc900ce0277874f0eb13c98d8087a19af7b724ce28475b0"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
