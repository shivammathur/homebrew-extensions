# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT85 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.6.tgz"
  sha256 "7b5fe1f68f2b1a62bd0394d4bf165eafe6b7ceb3fc20ab885e733d356db0d034"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "74f8bfece7c7b2dd3d901a25841aa8d449304f9232f1d158dc96882fa9dbdfd8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "51f1a0eb773b3252aa78bfd00018117534d038bc563600f7bb928fa0a0143da7"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "f4dc1d5939868b8db8967895102b5f308b8774bba0dc7e6da439a9dba7e44e67"
    sha256 cellar: :any_skip_relocation, sonoma:        "92fba3bfc67e48a364c729779b198515066a7303da87f8337965360005ef872d"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b2c3785ef1553a63c77675bf1e72f36aa344be70ebf9e0104a73470b83419c44"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "6b64501b2ae69bae28de0de0b6e878e3bcddda69031666879efb8b7b902ada99"
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
