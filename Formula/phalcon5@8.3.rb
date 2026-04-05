# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Phalcon5 Extension
class Phalcon5AT83 < AbstractPhpExtension
  init
  desc "Phalcon5 PHP extension"
  homepage "https://github.com/phalcon/cphalcon"
  url "https://pecl.php.net/get/phalcon-5.11.1.tgz"
  sha256 "8331f47cf760dbaf13ae2d77d63971005b03df40279dec97ede4b537d14c9591"
  head "https://github.com/phalcon/cphalcon.git", branch: "master"
  license "BSD-3-Clause"

  livecheck do
    url "https://pecl.php.net/rest/r/phalcon/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "c38891b8c4ec973b4f1b9084c0b6229e2393ee1d9bceaca1c18cdec2e0806c40"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "22347ee41e28939daebc7a86db7379efb533f679f3a66b4a84e809b3f61c7c7c"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "3f78242ee528f23c5035bda8f99f1af6496af3a63a08819093c8eceef62d6406"
    sha256 cellar: :any_skip_relocation, sonoma:        "e9c79c34dd9372c162add90d3694f286e28658679a2d94f398c040b2f8649bdf"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "b8f14865551e59b035785d8033beb96514071273c285ee64077faf0006ea679e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "84a75069404a3524ca454c1add7016911095fa7496837d4d9e837e3828830779"
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
