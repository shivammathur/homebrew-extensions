# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT84 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 2
    sha256 cellar: :any,                 arm64_sonoma:   "0cccda1455883e85f8e0d068fdc4a86444a54e9ca17db86016ea4f1c347a5cae"
    sha256 cellar: :any,                 arm64_ventura:  "d1bc72efd98d02356fdcac3145663b5da79f877072acad1afac8ef4d4c30cd65"
    sha256 cellar: :any,                 arm64_monterey: "e29799cf058e8c262f3f9f4fdfd645e227e22fd61dcbbfa73188c11927ed3ece"
    sha256 cellar: :any,                 ventura:        "fb4b53442d802570040b813802955a09ac8eabbd69092994d75a767d8609b832"
    sha256 cellar: :any,                 monterey:       "fef281b4c6de8defb15ddf89db6b6a80441a5dac92d8af285cb1980b39e2ff85"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4b411816f9352f86d4c7dd3a3dd44a1f0b235a1c7cc21d7575cd4b25f5433c91"
  end

  depends_on "librdkafka"

  def install
    Dir.chdir "rdkafka-#{version}"
    patch_spl_symbols
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--with-rdkafka=#{Formula["librdkafka"].opt_prefix}"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
