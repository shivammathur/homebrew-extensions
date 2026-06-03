# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT81 < AbstractPhpExtension
  init
  desc "Xlswriter PHP extension"
  homepage "https://github.com/viest/php-ext-xlswriter"
  url "https://pecl.php.net/get/xlswriter-2.0.2.tgz"
  sha256 "a85ce71f02eafb2617ab125b8c97677ec8b4eab3cd81f32478a5eb44fe55f145"
  head "https://github.com/viest/php-ext-xlswriter.git", branch: "master"
  license "BSD-2-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/xlswriter/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "f9e671a5c458e290b84b8694a3b9811b6c430ee93a8cf35eb77fa5091556d8e8"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "7e82af5c169a7fbbb9dde11bb211afb331b0a3c5945078860b12cdeee4e30000"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "a96d1e50fae1b9725e15c65ba07dff1d6199ceadb323587c4ce49ecc5328dd79"
    sha256 cellar: :any_skip_relocation, sonoma:        "dd44795e8253e9ef788ea885cc1c25017887980680f386552ecfa1a0d6527545"
    sha256 cellar: :any,                 arm64_linux:   "b284ac7b2d0db0e614d969d02345be4b5f82e19a3d7f7bafc3fb8c47e6713361"
    sha256 cellar: :any,                 x86_64_linux:  "aca5ec5ad6c90ebedfff21c02602317d4f0ee5ab64b02b82f5a5582e2363b656"
  end

  def install
    args = %w[
      --with-xlswriter
      --enable-reader
    ]
    Dir.chdir "xlswriter-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, *args
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
