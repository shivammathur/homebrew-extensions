# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT80 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "8c79a9e928d7b545ad14237011366f1d2a82161ede1c4497e2b276e4494552e3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "5e926f6de691ede7489542b196436431daf4e9b3bd37510fb892f1efa598123d"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "5a2ecd2bd3d1fff02ad07e16a3e5ac323460771abaddac7da4d3e2e915af3319"
    sha256 cellar: :any_skip_relocation, sonoma:        "8b170b4decdb8c8b662c69afeed39868bf084e82918fc009f09d80d9fc5270f7"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7059d61265993a0a51a0749e11f75437e757722bce7aa83058d7bc236b348427"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "03d18369e0acab17f43b6c3be03cc3c1bd351bf544ae88dde6e6c65fa8634583"
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
