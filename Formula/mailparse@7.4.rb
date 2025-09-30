# typed: true
# frozen_string_literal: true

require File.expand_path("../Abstract/abstract-php-extension", __dir__)

# Class for Mailparse Extension
class MailparseAT74 < AbstractPhpExtension
  init
  desc "Mailparse PHP extension"
  homepage "https://github.com/php/pecl-mail-mailparse"
  url "https://pecl.php.net/get/mailparse-3.1.9.tgz"
  sha256 "ecb3d3c9dc9f7ce034182d478b724ac3cb02098efc69a39c03534f0b1920922b"
  head "https://github.com/php/pecl-mail-mailparse.git", branch: "master"
  license "PHP-3.01"

  livecheck do
    url "https://pecl.php.net/rest/r/mailparse/allreleases.xml"
    regex(/<v>(\d+\.\d+\.\d+(?:\.\d+)?)(?=<)/i)
  end

  bottle do
    root_url "https://ghcr.io/v2/shivammathur/extensions"
    sha256 cellar: :any_skip_relocation, arm64_sequoia: "53e158077fa6b59656356b0b81018906b0bf88443f9ecbb3b596b3d3202db949"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:  "09e1b1d2da039be4c63c287b16fd8e7224984831551aa382857873de81e3b47e"
    sha256 cellar: :any_skip_relocation, arm64_ventura: "85f4ef34a261dbddeaf8b813522cb23a7916a8be8733dc060a095c7bedf05230"
    sha256 cellar: :any_skip_relocation, ventura:       "588d02496729380a62a036a670b052718afd59f5ce834f4a4c250c40b3fcab1a"
    sha256 cellar: :any_skip_relocation, arm64_linux:   "7f6808565e918eef78e74e5847d46a51edb9378ab32c4b69ca816a147b9da196"
    sha256 cellar: :any_skip_relocation, x86_64_linux:  "4b2c0f59ceee443241f4911a194551bc3869f9a266eb416ad14ff89699a679ec"
  end

  def install
    Dir.chdir "mailparse-#{version}"
    safe_phpize
    system "./configure", "--prefix=#{prefix}", phpconfig, "--enable-mailparse"
    system "make"
    prefix.install "modules/#{extension}.so"
    write_config_file
    add_include_files
  end
end
