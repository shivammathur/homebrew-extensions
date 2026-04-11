# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT85 < AbstractPhpExtension
  init
  desc "Ds PHP extension"
  homepage "https://github.com/php-ds/ext-ds"
  url "https://pecl.php.net/get/ds-1.8.0.tgz"
  sha256 "19abac84376399017590e11c08297e6784e332ec7eb26665a55f8818333d73c0"
  head "https://github.com/php-ds/ext-ds.git", branch: "master"
  license "MIT"

  livecheck do
    url "https://pecl.php.net/rest/r/ds/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "5c00fcbbb9844a3e18246201e0bae15a22ec442dccf7d040bf8839f15c3ed920"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "c18dd96cce162fc9ccc2659118f49beca3d829be3e3c33d3b401f1f9fcccb10a"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "e620fae2db211ddff102436ab44b4bfa3e195f04f03d4aff7664c5ba43400714"
    sha256 cellar: :any_skip_relocation, sonoma:        "31f14a76e28734552357fb3ffeb791d4f1fa065d5acd5a8dde08f3f95934c8e1"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "3a27e9b51eb7c87d5de157e9ed8fa1dfc59bac25522a29e6825c53d75835f91b"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "26ca1083d0ece68328ca3efd19d47b45651d782a15a08921e073b8d03230a67a"
  end

  priority "30"

  def install
    Dir.chdir "ds-#{version}"
    inreplace "src/common.h", "fast_add_function", "add_function"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-ds"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
