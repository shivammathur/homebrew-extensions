# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT74 < AbstractPhpExtension
  init
  desc "Rdkafka PHP extension"
  homepage "https://github.com/arnaud-lb/php-rdkafka"
  url "https://pecl.php.net/get/rdkafka-6.0.5.tgz"
  sha256 "0af6b665c963c8c7d1109cec738034378d9c8863cbf612c0bd3235e519a708f1"
  head "https://github.com/arnaud-lb/php-rdkafka.git", branch: "6.x"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/rdkafka/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any,                 arm64_sequoia: "8c356d703627baed3be62828d7b9fd1e2eafd5992013feb2ecb27828991ed5e4"
    sha256 cellar: :any,                 arm64_sonoma:  "76aafba2831ac31d3384b5ff12d438b091be137396baca05e107bbbae708ef83"
    sha256 cellar: :any,                 arm64_ventura: "bf08fe7125091c5009acf977b1de7389116799ebfa174b006bdb2e91f533751b"
    sha256 cellar: :any,                 sonoma:        "cbc572291793e8ea96b778acf86bc432eb4fbc5417a408b5aeb840a15191d9e0"
    sha256 cellar: :any,                 ventura:       "0de531e8b3b7f43788a9b57e86e44528bf8c0b2de5b1f89170536d7ecbe83314"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d932a9f4842f59d1a0322aa5c322bd6ec617b980e6fdd929152260f977af4a12"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2b24068e6a1a4391bbb0fc132a2362dac84c68ea22d84a2f22d92c846d0f0bb9"
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
