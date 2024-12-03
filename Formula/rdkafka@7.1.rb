# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT71 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git"
  license "MIT"

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "4b8369585e08d99383e875aaea4825229a4471b4888647b0cc8283eef22881ba"
    sha256 cellar: :any,                 arm64_sonoma:  "3b5d562598860e66211db770f2ef31b4239cad21a394078b3d417e27df11c4ea"
    sha256 cellar: :any,                 arm64_ventura: "4938a0bb1066468245ad487d7ff3d092079541722e21cffaff34618ecaf5b9e6"
    sha256 cellar: :any,                 ventura:       "3d054cad15b481fd89907f0e0882770dd1e7fb135b48cf2335acf4f094a73b62"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f859fb0b50443bdd85c0dabe51c9c49ceb3847457cfc258fea2e7510c77020a2"
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
