# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT82 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.9.1.tgz"
  sha256 "e2a7720c066e7c0d1be646d142634497672b64a4660cea4edb4bcdb2df59be8a"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "b9abc2858a32f104ceeb66f47096b9e872d9948fc819588357e11fd401f574a2"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "0f07f02d559a7e834b978d4ec8e8e0dda5b2f8ff7f46d0e44db73c18290f31e0"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "52d019db5b6faa92d4ffcc2548ab0353cd8908dac8436177c61fc2d6a878161d"
    sha256 cellar: :any_skip_relocation, ventura:       "b9df5eabf0662106ca5479dc5294c754f36bbcce76d6c3904ed36c6457a235af"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "2c629353f40060bad6944617dc1c6d47dcc99fc62206c1704ffff9341f01924f"
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
