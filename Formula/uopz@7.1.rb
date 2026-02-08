# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Uopz Extension
class UopzAT71 < AbstractPhpExtension
  init
  desc "Uopz PHP extension"
  homepage "https://github.com/krakjoe/uopz"
  url "https://pecl.php.net/get/uopz-6.1.2.tgz"
  sha256 "d84b8a2ed89afc174be2dd2771410029deaf5796a2473162f94681885a4d39a8"
  head "https://github.com/krakjoe/uopz.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/uopz/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "d27854b0256580ce3ba2ce5fc4b9d54003163fc2767a732db9420eabed880773"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "e2148f9c7d6ada14a07473994f31594d55eb7c59557664806504a720b6363698"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3bea6df7ec7efc967672fb9eba2332f63c7efbd90d5554e8ded8076584458bd4"
    sha256 cellar: :any_skip_relocation, sonoma:        "4652f809b96f5cb178c9628a91cd23d7afe91f235f58645bbc7552b038d90497"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "c5aaa7c67b87b64a7670e27ab58340c1fa5a24bac875e272bde0910d3971e38f"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "73188d06f788277e8b537fab94e964bfaaafc5f90451470e17c0bde185ece2ba"
  end

  priority "10"

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
