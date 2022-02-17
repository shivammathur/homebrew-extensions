# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.1.tgz"
  sha256 "8a4abe701e593d1042c210746104f4b04b15ac98db6331848eed91acadfcf192"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "3936c142df631921540482ee3b977af204bf9e7391bed852c8acc7c58348b8fa"
    sha256 cellar: :any,                 big_sur:       "c05b9cccacffb1079a9d32144f378d552dc92e2f7f2ee1b70c1f55d45d228a7b"
    sha256 cellar: :any,                 catalina:      "f066de08fc45427acb7a53be248db550357a40c5cc48c61b4c1452284223e8d9"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6560d44c8abcc316601492188256a9b780e33cc69ff3867c5c6a30b84089a89a"
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
