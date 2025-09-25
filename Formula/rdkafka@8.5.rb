# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT85 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  revision 1
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_tahoe:   "60fa25cf3db499275ce312343b0b804c0f465c382a5c467ddb3c7a2098993365"
    sha256 cellar: :any,                 arm64_sequoia: "c52f97b04494c9de3bfb2de8189525f7507df1af165161c3e688088e78ed7d4c"
    sha256 cellar: :any,                 arm64_sonoma:  "e8e94d3c2609584b20d4a225410a27969a5ba1be0a0bf77baccbde9c5a9f1273"
    sha256 cellar: :any,                 sonoma:        "4c9a5f0caae780c4c78c7d7dde4967e132bdb32598647019d88b816c46012cac"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d4c44160693318f4f8c3a063aee1f412f780e66a2612ca0bb2f70bda2ddc0d10"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "0e6994b260400dd7d2f954b59d12cb29712263af8beede2941975c7cdd9655c0"
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
