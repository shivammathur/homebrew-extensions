# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT72 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.2.tgz"
  sha256 "faaf617f1cae0e85430306e078197313fc65615c156ff16fc7fc3b92de301ef5"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_monterey: "93b162ca83386d5fc49e9fbc76354af10f607ace2931f57dbabaed0a08e77cce"
    sha256 cellar: :any,                 arm64_big_sur:  "33fc33a035e0eb55b2eb39834739660118e8c8f8e3c7fb923d7ad10de70c24d5"
    sha256 cellar: :any,                 monterey:       "296d6657224d532c29324dbc6687b24fdd4fbacda7c1a42ff0ad7745cb0e226d"
    sha256 cellar: :any,                 big_sur:        "8bf9f129f9691a7f180c97623133cea7de01bcdbdda64b941fbe5e9e1bfb2711"
    sha256 cellar: :any,                 catalina:       "ebd8a3958f94e88e00d21a62d717c350ad3088dcff6b73fa3b169c2a27f51e22"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "d69edfc5e5ff27476304b8b6efce2f5cc7317a4d8e76495922205ee32f6c507a"
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
