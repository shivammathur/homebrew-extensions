# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Apcu Extension
class ApcuAT84 < AbstractPhpExtension
  init
  desc "Apcu PHP extension"
  homepage "https://github.com/krakjoe/apcu"
  url "https://pecl.php.net/get/apcu-5.1.27.tgz"
  sha256 "1a2c37fcad2ae2a1aea779cd6ca9353d8b38d4e27dde2327c52ff3892dfadb3f"
  head "https://github.com/krakjoe/apcu.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/apcu/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "a67612aaf7e390b961f4a5b0dc239b6b57c8b7bcfcd753877301d63e928b9718"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "7653cb673ede9fc22fcc5d4f4bb6b19368daca2e24343bd6ed0a27d6885f0d97"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "dd96ba99a8a949a850760be52fdd1d28357d4c639ce6f441334752340aedd398"
    sha256 cellar: :any_skip_relocation, ventura:       "aef63984deeb6ba9eeec548d5302e90dda1945d81ccc7c2b35d419573dd38a52"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "75154a8fd8d8622e505193f748e5e2b1fc4b59408d33e859909e82eed85713b4"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "e8141492de005f661725d0836e7c10ec66f677165e8dd0fcae3d2a843b432f6b"
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
