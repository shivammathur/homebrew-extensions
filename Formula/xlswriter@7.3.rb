# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT73 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "0a1950e1c1b05733424c6b58daaa2dbb69ca3da125556aca2b545320758bd43f"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "f146a7d552450242e9d3a5d10a64e87af7c833856c20586d8a67dd81ffd1d1cf"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "6324baa8fc69f27f0149fa0dc9da6457812bacd9e220488ef090c627f1518c87"
    sha256 cellar: :any_skip_relocation, sonoma:        "b88c128ac843a378d5ebcded248cb3be849d9f2d4c391c34c8e6eaa1b0d2e276"
    sha256 cellar: :any,                 arm64_linux:   "2a63a5302f10e9263fba36491d23d968a42c96973e7256b0df2ba02bc9405ba4"
    sha256 cellar: :any,                 x86_64_linux:  "4940068194d6d667fea1e99f768e393449cd4f0c1be9baeecd260d970f95f97c"
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
