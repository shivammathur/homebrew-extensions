# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT73 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d06790426c7207e5510cae8342a93c284c68d805b41d5a9ff78666d99cc7e930"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "8edfd5eacfa11d3f69f85c56ca69118f720c9514e55543f57528437c1ce481a3"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6eb5d1abbf932be09eb1218de93163bf78ff14632b85a25aafb296199ede66a3"
    sha256 cellar: :any_skip_relocation, sonoma:        "9d761d953b1996889c5b3255fc01fc118fc2b8abbcea6090c2c68c96601d6d44"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d744cc35ce10d90de2dbe53fc963dc0dc928b7fc51b6ffb6261d4275f4ad5874"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b8ee574f019488afa04e2f24f12abd66babf75f5821a8fbd36ef1db0d1530748"
  end

  def install
    Dir.chdir "excimer-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-excimer"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
