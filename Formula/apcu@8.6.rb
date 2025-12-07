# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT86 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d386724719c417ae2041d677294adfc86b49ec638b0934345ec9a0cf31999735"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9956cd71880bd075bd368cba40bf3b1fccbe126e097dcb35d1f1bba5685f7a0d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0d0750230e64667a57d22eb5684faec81edf65d6a341c2320c035ee7311518c8"
    sha256 cellar: :any_skip_relocation, sonoma:        "ed6bb3a226f5faf4609eaa62ad5984d9216b795ea1c07abca39341ff5eb5edb9"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b341f536e521c8fbc2f40ecf367b4deedaac8e9c1f463693c77631a1bd21dc30"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "f846caa0aeb3b687b2713996e7c58e2c41e9529fef9f8254be1fe0e864248b12"
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
