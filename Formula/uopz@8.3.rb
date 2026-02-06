# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT83 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-7.1.1.tgz"
  sha256 "50fa50a5340c76fe3495727637937eaf05cfe20bf93af19400ebf5e9d052ece3"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c036bbbe84afba01a6c94e22764520e6b029b7f9faec14311b35ecc8bbc31445"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "2a5aba15f4262499e7ce960ce4950d6105282ee032430f9e9ef736f846c52949"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0988b4db7223851feca81abdbd82b0277032246e6fb787c2ebf65765feba819e"
    sha256 cellar: :any_skip_relocation, sonoma:        "677baf73aea5ea9149519a2783c778cfa636e7602c9a6525ec3b88b39d876cce"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "360e75cdde217479c5ab09a634e52cc67a4ac8c6e6e1bb789fe324a4578b3500"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "b9dbabdef8466f4cb811f16c1fb1181e5c5a4ba7e2eee5b6b2d9e92fba6139bb"
  end

  def install
    Dir.chdir "uopz-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-uopz"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
