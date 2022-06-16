# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_big_sur: "bb285c7a7fbf4f19221b4756256047dd6a93c21b17463dd489aee2cdca14bf2d"
    sha256 cellar: :any,                 big_sur:       "08d672c5f2f2125c3ed579d6d04669fd463bc5220e7d10a851ca468303d997c6"
    sha256 cellar: :any,                 catalina:      "1e7567f1bdb637fefe6b1e2758b867e337b4dea30ebeed30cea2843cd4b51e51"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "39d7358099598d7c52bd2f41731408f1d1a057f348a890a21535eba277f81a2d"
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
