# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT80 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia:  "c81925d75a28d9b72431366256eb56f9dace569d77cfe3781efa46464123ba80"
    sha256 cellar: :any,                 arm64_ventura:  "68aa1f76c68fbb5ebe182c72945118314ad4801ebeef98e9b7c771e1ad3be4b4"
    sha256 cellar: :any,                 arm64_monterey: "1f370aabcd928328a628bdd6db69dab30f05780a20a9e2cd44075dfafac5a4a3"
    sha256 cellar: :any,                 arm64_big_sur:  "25db8389bc29ac6ddbf8134d294ac6e275a901db5e9d9c67938707dace74e7bc"
    sha256 cellar: :any,                 ventura:        "0d5ced5383d57cba1df00488bcfd335768ef9c6593568c90cacf06c671b85053"
    sha256 cellar: :any,                 monterey:       "d40d8bd25a80c2443de1477c4e7721c230a29452a315f23b457faa7acd1d28bd"
    sha256 cellar: :any,                 big_sur:        "9a80f971196300a1eb0383149d521d222f1d450d215c4fbc28b39f0d7886b720"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "4833e20e2b090f510848c82308e954e4da2bd370e1dc0532d8f263db9b8132a7"
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
