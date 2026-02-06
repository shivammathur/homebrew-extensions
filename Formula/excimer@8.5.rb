# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Excimer Extension
class ExcimerAT85 < AbstractPhpExtension
  init
  desc "Excimer PHP extension"
  homepage "https://www.mediawiki.org/wiki/Excimer"
  url "https://pecl.php.net/get/excimer-1.2.5.tgz"
  sha256 "cf49acd81a918ea80af7be4c8085746b4b17ffe30df3421edd191f0919a46d1d"
  license "Apache-2.0"

  livecheck do
    url "https://pecl.php.net/rest/r/excimer/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "92ae786c27820b1b97d72c38e13e649de44de346968c8c55d25e027b7d59b689"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f4adc9c5f5f2fe46372e1da4e21a60b1e1bca9c29b2e565f3f2f98a29ab252ce"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d9d7e7f5ac387adf5eac4bcabb1a2c1134ddbfda80b6f636de259f286b07a7ce"
    sha256 cellar: :any_skip_relocation, sonoma:        "c4a779d09ad0e4bbbe424c7158a2ae0a328c6c7138ecdf34ad4fb300cd8d1975"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "ee27268e3f06db87cbf3e2978ac2acef4ee4c5bc5bf622c53445b931680ca0ae"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4eb4e497f1ed1901811515033d8182c438dccb30f8f0bf4af3ca170ca27f8f4e"
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
