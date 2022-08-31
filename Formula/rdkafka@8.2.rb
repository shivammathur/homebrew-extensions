# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT82 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "35e365341458eee5acfbbdcc3b1a02f63368f77690bb9be149a1231805d5d77a"
    sha256 cellar: :any,                 arm64_big_sur:  "12a3ad4a1d3334f650918f3b5f16ca7bbbf1380864375ca1e49c03596e76e2b4"
    sha256 cellar: :any,                 monterey:       "4b2cb3c14e89ae2c5a619ce46f410f08d1bdd97486c6e8183a74420e4a62016c"
    sha256 cellar: :any,                 big_sur:        "8f0864c54d6495421f9d4cd0e3e555b52007e44de83e3109b5bb6e0eb46642d0"
    sha256 cellar: :any,                 catalina:       "04a0b644e64e9961b13378f5a2da9bd0ae362fc591cc35eab5fda2830a2a5c83"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "2c5dee795c471f0bd117b407efec5bbf85dea17faffb4fc33e4434abf6316a59"
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
