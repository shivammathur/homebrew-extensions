# typed: false
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.3.tgz"
  sha256 "12eaab976d49697e31f1638b47889eb5ec61adb758708941112b157f8ec7dd48"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://github.com/shivammathur/homebrew-extensions/releases/download/rdkafka@7.4-6.0.3"
    rebuild 1
    sha256 cellar: :any,                 arm64_monterey: "1ee61163b0db84696b5277fcd028fedc8a1900915ecab722866294c281867f49"
    sha256 cellar: :any,                 arm64_big_sur:  "afbf667a30604fd3b4a8eb52a7ddbfad86b8cd0975bd84bbc3657e3381dec434"
    sha256 cellar: :any,                 monterey:       "1337723cf14bc0714bc4a2f4b44802943f8206217c545c1426fbb00c9bdcb76e"
    sha256 cellar: :any,                 big_sur:        "b7078158c9310d58e4cd9b884899ec4d2dc6c3eeff94f69a38606baab2415c6c"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "5e40622af65a1f65972f4bc6b3c09f3fae098a52494b70eeffd95f9b77bc63f9"
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
