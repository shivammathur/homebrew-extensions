# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Xlswriter Extension
class XlswriterAT72 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "59b1ce7261b82262c61d5ea5fdd4601a7f05dd9ad52bd3c8f87e95b04712f31c"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "09809a2a688350107e7492380cc532093865e023649ede942aed49cfd0d6338e"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "2b9949fcefcab867b107c3bfc2e183f27328f110c492d37aeddb447bf502ed70"
    sha256 cellar: :any_skip_relocation, sonoma:        "6bce63c850366e5b235d96ee167eff87f6d0196fc6f4b0c0079c6ae642428405"
    sha256 cellar: :any,                 arm64_linux:   "c86004271ee9d2de53e5206db3e12a236af85b14a00bd96907e2921adb481950"
    sha256 cellar: :any,                 x86_64_linux:  "19960406e1bdb3dcae83f54a7344ae4bb8fcc178aa7eec07ae3354efff6b6de7"
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
