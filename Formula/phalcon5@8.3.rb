# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.22.1.tgz"
  sha256 "328bc4998d56f287dfc8ada9e57725fc2b2fa2ec5f56545461a60af9d7905167"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_golden_gate: "2e3c21cd7075ec0f2330c3f296d4d2f729dfc4fac4cc59beefe539998c8fd83c"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:       "22d70bcdc9a92cf6528e38008f5f6d69c0122a5e0b020108bfcf8b6ce15310f3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia:     "c94eb8fea558b5b7d3ecf8e1d29c941fc34dceedf2c9614a1a632276239a2381"
    sha256 cellar: :any,                 arm64_linux:       "64032779f0ebce71aee135553b3f45f41c34120274ffb43ed1fcead9caddfc47"
    sha256 cellar: :any,                 x86_64_linux:      "9d430f88a6c76ad71d6a48bd993bc10a3c3bd88f410831d60c71befc14abc706"
  end

  depends_on "pcre"

  def install
    Dir.chdir "phalcon-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-phalcon"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
