# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT84 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.2.0.tgz"
  sha256 "cc5111ae17bfa36efcc5ef23dcf75b6501593ac264c196aad3e39cd4ad765332"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_tahoe:   "aa056b762e1739def6b5c65d43263efb7b6cd4502962dd6cb7b439382e560efc"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "9abc5881960739b1eedaeeac62e88574d3b7f94744329bf99e50fafcda2110ae"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "01144e658faba2051c674d86f5a6fd8c4da1014354efea9db499e0f6fc210a75"
    sha256 cellar: :any_skip_relocation, sonoma:        "d8235b9a4c1f390a155e61205e6bbd8aa3d92505279c5332589b140832e18275"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "753227ad981b23f4295c3e229ef65694e816ef264b4eae55cec7fe940306ee75"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "18a5d58401ea66f0602d6c11554b609def9a36b986c735001a313a06c4cbed00"
  end

  def install
    # Work around configure issues with Xcode 16
    ENV.append "CFLAGS", "-Wno-implicit-function-declaration"

    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
