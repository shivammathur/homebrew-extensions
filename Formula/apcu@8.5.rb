# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT85 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.28.tgz"
  sha256 "ca9c1820810a168786f8048a4c3f8c9e3fd941407ad1553259fb2e30b5f057bf"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5f8b0e6cb01ce00565add83a7b791f05bbc5a4f6b7a7747ee49982d45f767ee4"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9a269a86e97e2bb4e8a40e4c495e37e135ba60d5a1d48d0dc854a4b4b4e75808"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "fa66d222ed8549d360d1b54335d302a5c4255b7ea16747441e31e7d98a534d69"
    sha256 cellar: :any_skip_relocation, sonoma:        "4f32112c48a68f079917c60161f4ea9d3346fb5b6fb0714b9631adf49d20f032"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "d40524b4a2c9fecdca5b07494e54d9e0ed430b89cda545ae1b51b8828d79d3c4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "06b500da6983c08c1c91545d1c33be7ecd506dda41dc27f6e938db10712b53ee"
  end

  def install
    Dir.chdir "apcu-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-apcu"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
