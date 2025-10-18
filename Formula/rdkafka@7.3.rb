# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Rdkafka Extension
class RdkafkaAT73 < AbstractPhpExtension
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
    sha256 cellar: :any,                 arm64_sequoia: "18bf82e8cb12a2eb8a5ed381dea064677fccd10812f644c7f0c5448cf3814f6a"
    sha256 cellar: :any,                 arm64_sonoma:  "baf74dee7d24513e88bdf39fbba3afcbfa3bad2762fbe5d76fc3073a73425161"
    sha256 cellar: :any,                 arm64_ventura: "f8a8b59d18eea35c1f07552b178984cbbf89e80152c10bde3a3eb8a3d91e2251"
    sha256 cellar: :any,                 ventura:       "c4ac217b7d1ceada43b0d4909cf9ebd49c0c8d5344780b34252d9263ced8b57d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7214d4c7631d4916f3628c855907cacccef1c68e0f5e081f59400003789428fc"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "9f00ad2abe5780edaf58552db46ed3fad04ab49390fd4a410ca7168761130aa9"
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
