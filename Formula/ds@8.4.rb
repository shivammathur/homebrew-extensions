# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Ds Extension
class DsAT84 < AbstractPhpExtension
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
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "471dad9cd503eae17728ce85913b5a87abe0a7dfdb9e59d363f60294a0fb9de3"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "4f171afcae98361ccba1a0a1f209ddcb7f865081d8e2e2bc7695d35bf68a0616"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "d602f6d6a0bd9618bd8f5483cdbe504d80c126f917923df405eda31fc4daeb60"
    sha256 cellar: :any_skip_relocation, sonoma:        "b94aaa73c3943c4c2b01bedfe353d9abf0a9bb434df507244fdba8c12b112a0e"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "0183c0ecfbc45215dda5ddbb7c2419bad67c172eac367635754984c75d96cb39"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "c8e8830074d0feece2ad4504e47b3a0e5d12cd22945e12a40b33359923646fb8"
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
